*** Variables ***
${BASE_URL}         http://localhost:3000/api/v1
${DEFAULT_HEADERS}  {"Content-Type": "application/json"}
${AUTH_TOKEN}       None
${AUTH_HEADER}   Authorization=Bearer ${AUTH_TOKEN}
${TIMEOUT}          5s
