{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty as W

import Data.Text.Lazy
import Lib

import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.String (renderSvg)

main = scotty 3000 $ do
  get "/:shape" $ do
    let a = renderSvg svgDoc
    html $ (append (append "<div class='hello' style='width: 100%; height: 100%;'>" (pack a)) "</div>")

svgDoc :: S.Svg
svgDoc = S.docTypeSvg ! A.version "1.1" ! A.width "100%" ! A.height "100%" ! A.viewbox "0 0 3 2" $ do
  S.g $ do
    S.rect ! A.width "10%" ! A.height "2" ! A.fill "#008d46" ! A.transform makeTransform
    S.rect ! A.width "1" ! A.height "2" ! A.fill "#000000"
    S.rect ! A.width "1" ! A.height "50%" ! A.fill "#d2232c"

makePath :: S.AttributeValue
makePath = mkPath $ do
  l 2 3
  m 4 5

makeTransform :: S.AttributeValue
makeTransform = rotate (- 50)
