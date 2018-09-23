json.version "1.0"
json.response do |response|
  response.outputSpeech do |outputSpeech|
    outputSpeech.type "SimpleSpeech"
    outputSpeech.values do |values|
      values.type "PlainText"
      values.lang "ja"
      values.value "お母さんからの連絡です。。。"
    end
    outputSpeech.card {}
    outputSpeech.directives []
    outputSpeech.shouldEndSession false
  end
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
