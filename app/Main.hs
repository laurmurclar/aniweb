{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty as S

import Data.Text.Lazy
import Lib

main = scotty 3000 $ do
  get "/:shape" $ do
      shape <- S.param "shape"
      S.html $ longresponse shape
