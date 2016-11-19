{-# LANGUAGE OverloadedStrings #-}

import Shapes
import Web.Scotty as W
import Data.Text.Lazy (pack, append)
import Text.Blaze.Svg.Renderer.String (renderSvg)

main = scotty 3000 $ do
  get "/" $ do
    file "index.html"

  post "/shapes" $ do
    description <- param "description"
    let svg = renderSvg (draw (read description))
    html $ pack svg
