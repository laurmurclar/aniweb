{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty as W

import Data.Text.Lazy
import Lib

import Text.Blaze.Internal as I
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.String (renderSvg)

main = scotty 3000 $ do
  get "/" $ do
    let a = renderSvg svgDoc
    html $ (append (append "<div class='hello' style='width: 100%; height: 100%;'>" (pack a)) "</div>")

svgDoc :: S.Svg
svgDoc = S.docTypeSvg `withAttributes` [(A.version "1.1"), (A.width "100%"), (A.height "100%"), (A.viewbox "0 0 3 2")] $ do
  S.g $ do
    S.rect `withAttributes` ((style (Fill "#008d46")) ++ [(A.transform makeTransform)])
    S.rect `withAttributes` (style (Fill "#000000"))
    S.rect `withAttributes` (style ((Fill "#FF0000") *** (Stroke "#00FFFF")))

makePath :: S.AttributeValue
makePath = mkPath $ do
  l 2 3
  m 4 5

makeTransform :: S.AttributeValue
makeTransform = rotate (- 50)

------------ COOL STUFF ----------------
----------------------------------------
withAttributes :: I.Attributable a => a -> [S.Attribute] -> a
h `withAttributes` [] = h ! A.width "1" ! A.height "1"
h `withAttributes` (x:xs) = (h ! x) `withAttributes` xs

-- TODO strokeWidth
data Style = IdentityS
        | Fill String
        | Stroke String
        | ComposeS Style Style
          deriving Read

fill = Fill
stroke = Stroke
s0 *** s1 = ComposeS s0 s1

style :: Style -> [Attribute]
style s = styleR s []

styleR :: Style -> [Attribute] -> [Attribute]
styleR (Fill c) xs = xs ++ [A.fill (stringValue c)]
styleR (Stroke c) xs = xs ++ [A.stroke (stringValue c)]
styleR (ComposeS s0 s1) xs = (styleR s1 (styleR s0 xs))
