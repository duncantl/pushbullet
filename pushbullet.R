library(RCurl) 
library(RJSONIO) # or json or JSONlite

devices =
function(key = getOption("PushBulletKey", stop("Need key")),
         ...,
         u = "https://api.pushbullet.com/api/devices",
         curl = getPushBulletHandle(key))
{
  ans = getURLContent(u, curl = curl, ...)
  fromJSON(ans)
}

getPushBulletHandle =
function(key = getOption("PushBulletKey", stop("Need key")),
         curl = getCurlHandle(), ...)
{
  curlSetOpt(userpwd = sprintf("%s:", key),
             httpauth = AUTH_BASIC,
             followlocation = TRUE,
             cainfo = system.file("CurlSSL", "certs.pem", package = "RCurl"),
             ...,
             curl = curl)
  curl
}



push =
function(device, body, title, type = "note",
         key = getOption("PushBulletKey", stop("Need key")),
         ...,
         u = "https://api.pushbullet.com/api/devices",
         curl = getPushBulletHandle(key))
{
  params = list(device_iden = device, type = type, title = title, body = body)
  ans = postForm(u, .params = params, style = "POST", 
                  .opts = list(...), curl = curl)
  fromJSON(ans)
}

#curl https://api.pushbullet.com/api/pushes -v -u key:  -d device_iden=u1qSJddxeKwOGuGW  -d type=note  -d title=Title  -d body=Body  -X POST
