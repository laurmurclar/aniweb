{-# LANGUAGE OverloadedStrings #-}
module Appearance where

import Data.Monoid
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A

data Style = IdentityS
        | Fill String
        | Stroke String
        | StrokeWidth Double
        | Style :*** Style
          deriving (Read, Show)

style :: Style -> S.Attribute
style IdentityS = mempty
style (Fill c) = A.fill (S.stringValue c)
style (Stroke c) = A.stroke (S.stringValue c)
style (StrokeWidth w) = A.strokeWidth (S.stringValue (show w))
style (s0 :*** s1) =  mappend (style s0) (style s1)

data Transform = IdentityT
           | Scale Double
           | ScaleN Double Double
           | Rotate Double
           | Translate Double Double
           | Transform :<+> Transform
             deriving (Read, Show)

transform :: Transform -> S.Attribute
transform t = A.transform (transformA t)

transformA :: Transform -> S.AttributeValue
transformA IdentityT = mempty
transformA (Scale f) = S.scale f f
transformA (ScaleN fx fy) = S.scale fx fy
transformA (Rotate d) = S.rotate d
transformA (Translate x y) = S.translate x y
transformA (t0 :<+> t1) = mappend (transformA t0) (transformA t1)
