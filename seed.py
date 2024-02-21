import json


def load_json_data(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)


def format_array_for_copy(array):
    # Format the array as a PostgreSQL array string
    return '{' + ','.join(map(str, array)) + '}'


def generate_copy_statements(data):
    # Generate COPY statements for COLLECTION_ENUM
    collection_enum = "COPY public.\"COLLECTION_ENUM\" (value, comment) FROM stdin;\n"
    for item in data["COLLECTION_ENUM"]:
        value = item["value"]
        collection_enum += f"{value}\t\\N\n"
    collection_enum += "\\.\n"

    # Generate COPY statements for configuration
    configuration = "COPY public.configuration (guild_id, logging_channel_id, mod_role_id, banned_user_ids) FROM stdin;\n"
    for item in data["configuration"]:
        guild_id = item["guild_id"]
        logging_channel_id = item["logging_channel_id"]
        mod_role_id = item["mod_role_id"]
        banned_user_ids = format_array_for_copy(item["banned_user_ids"])
        configuration += f"{guild_id}\t{logging_channel_id}\t{mod_role_id}\t{banned_user_ids}\n"
    configuration += "\\.\n"

    # Generate COPY statements for guild_forums
    guild_forums = "COPY public.guild_forums (guild_id, forum_channel_id, forum_collection) FROM stdin;\n"
    for item in data["guild_forums"]:
        guild_id = item["guild_id"]
        forum_channel_id = item["forum_channel_id"]
        forum_collection = item["forum_collection"]
        guild_forums += f"{guild_id}\t{forum_channel_id}\t{forum_collection}\n"
    guild_forums += "\\.\n"

    return collection_enum + configuration + guild_forums


def create_seed_sql_file(json_file_path, output_file_path):
    data = load_json_data(json_file_path)
    copy_statements = generate_copy_statements(data)
    with open(output_file_path, 'w') as file:
        file.write(copy_statements)
    print(f"SQL seed file created at {output_file_path}")


# Example usage
if __name__ == "__main__":
    json_file_path = 'seed.json'  # Update this path to your JSON file location
    output_file_path = 'hasura_discord_postgres/data/seed.sql'  # Update this path to where you want the SQL file saved
    create_seed_sql_file(json_file_path, output_file_path)
