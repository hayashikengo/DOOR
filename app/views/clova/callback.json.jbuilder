json.version "1.0"
json.response do |response|
  response.outputSpeech do |outputSpeech|
    outputSpeech.type "SimpleSpeech"
    outputSpeech.values do |values|
      values.type "PlainText"
      values.lang "ja"
      values.value @voice_message
    end
  end
  response.card {}
  response.directives []
  response.shouldEndSession false
end

# {
#   "version": "1.0",
#   "sessionAttributes": {},
#   "response": {
#     "outputSpeech": {
#       "type": "SimpleSpeech",
#       "values": {
#           "type": "PlainText",
#           "lang": "ja",
#           "value": "こんにちは。ピザボットです。どういったご用件ですか"
#       }
#     },
#     "card": {},
#     "directives": [],
#     "shouldEndSession": false
#   }
# }
