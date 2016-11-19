{-# LANGUAGE OverloadedStrings #-}
module Shapes where

import Appearance
import Text.Blaze.Internal as I
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A

-- TODO add more shapes
data Shape = Rect
              deriving (Read, Show)

shape :: Shape -> S.Svg
shape Rect = S.rect

type Drawing = [(Shape, Style, Transform)]

draw :: Drawing -> S.Svg
draw d = S.docTypeSvg `withAttributes` [A.version "1.1", A.width "100%", A.height "100%", A.viewbox "0 0 3 2"] $
            S.g $
                drawShapes d

drawShapes :: Drawing -> S.Svg
drawShapes [d] = shapeToDrawable d
drawShapes (d:ds) = shapeToDrawable d >> drawShapes ds

shapeToDrawable :: (Shape, Style, Transform) -> S.Svg
shapeToDrawable (sh, st, tr) = shape sh `withAttributes` (transform tr : style st)

withAttributes :: I.Attributable a => a -> [S.Attribute] -> a
h `withAttributes` [] = h ! A.width "1" ! A.height "1"
h `withAttributes` (x:xs) = (h ! x) `withAttributes` xs
