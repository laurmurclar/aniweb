{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty as W

import Data.Text.Lazy
import Lib

import Text.Blaze.Internal as I
import Text.Blaze.Svg11 ((!), rotate)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.String (renderSvg)

main = scotty 3000 $
  get "/" $ do
    let a = renderSvg svgDoc
    html $ append (append "<div class='hello' style='width: 100%; height: 100%;'>" (pack a)) "</div>"

svgDoc :: S.Svg
svgDoc = S.docTypeSvg `withAttributes` [A.version "1.1", A.width "100%", A.height "100%", A.viewbox "0 0 3 2"] $
  S.g $
    draw (read "[(Rect, Fill \"#FF0000\" :*** Stroke \"#00FF00\", Rotate 50.0 :<+> Scale 0.5)]")

------------ COOL STUFF ----------------
----------------------------------------
withAttributes :: I.Attributable a => a -> [S.Attribute] -> a
h `withAttributes` [] = h ! A.width "1" ! A.height "1"
h `withAttributes` (x:xs) = (h ! x) `withAttributes` xs

-- TODO revise if these would be better as diff types eg. Double
-- TODO add more style options
data Style = IdentityS
        | Fill String
        | Stroke String
        | StrokeWidth String
        | Style :*** Style
          deriving (Read, Show)

style :: Style -> [Attribute]
style s = styleR s []

styleR :: Style -> [Attribute] -> [Attribute]
styleR IdentityS xs = xs
styleR (Fill c) xs = xs ++ [A.fill (stringValue c)]
styleR (Stroke c) xs = xs ++ [A.stroke (stringValue c)]
styleR (StrokeWidth w) xs = xs ++ [A.strokeWidth (stringValue w)]
styleR (s0 :*** s1) xs = styleR s1 (styleR s0 xs)

type Drawing = [(Shape, Style, Transform)]

draw :: Drawing -> S.Svg
draw [d] = shapeToDrawable d
draw (d:ds) = shapeToDrawable d >> draw ds

shapeToDrawable :: (Shape, Style, Transform) -> S.Svg
shapeToDrawable (sh, st, tr) = shape sh `withAttributes` (style st ++ transform tr)

data Shape = Rect
              deriving Read

shape :: Shape -> S.Svg
shape Rect = S.rect

-- TODO translate
-- TODO decide on cons or concat
-- TODO HOF
-- TODO add more transform options
data Transform = IdentityT
           | Scale Double
           | Rotate Double
           | Transform :<+> Transform
             deriving Read

transform :: Transform -> [Attribute]
transform t = transformR t []

transformR :: Transform -> [Attribute] -> [Attribute]
transformR IdentityT xs = xs
transformR (Rotate r) xs = xs ++ [A.transform (S.rotate r)]
transformR (Scale f) xs = xs ++ [A.transform (S.scale f f)]
transformR (t0 :<+> t1) xs = transformR t1 (transformR t0 xs)

-- TODO read it in from the webpage
-- TODO break into lib files
