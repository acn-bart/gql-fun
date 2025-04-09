#!/bin/bash

# Read the content of the file 'foo'
encoded_input=$(cat foo)

TOKEN=$(echo "$encoded_input")

# Define the GraphQL endpoint
GRAPHQL_ENDPOINT="https://graph.microsoft.com/v1.0/me/joinedTeams"

# Run the curl command with the decoded TOKEN
curl -X GET "$GRAPHQL_ENDPOINT" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN"
