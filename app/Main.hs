{-# LANGUAGE OverloadedStrings #-}

import Shapes
import Web.Scotty
import Data.Text.Lazy (pack, append)
import Text.Blaze.Svg.Renderer.String (renderSvg)

main = scotty 3000 $
  get "/" $ do
    let a = renderSvg svgDoc
    html $ append (append "<div class='hello' style='width: 100%; height: 100%;'>" (pack a)) "</div>"

-- TODO read it in from the webpage
