key=$(cat ~/.openaikey)
curl=$(curl https://api.openai.com/v1/chat/completions -s \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $key" \
  -d '{ 
  "model": "gpt-3.5-turbo",
  "messages": [{"role": "user", "content": "'"$1"'"}]
}')
message=$(jq ".choices[].message.content" <<< $curl)
message="${message:5}"
message="${message::-1}\n"
echo -ne $message
