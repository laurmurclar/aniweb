{-# LANGUAGE OverloadedStrings #-}
module Appearance where

import Data.Monoid
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A

-- TODO revise if these would be better as diff types eg. Double
-- TODO add more style options
-- TODO make strokewidth reasonable
data Style = IdentityS
        | Fill String
        | Stroke String
        | StrokeWidth String
        | Style :*** Style
          deriving (Read, Show)

style :: Style -> [S.Attribute]
style s = styleR s []

styleR :: Style -> [S.Attribute] -> [S.Attribute]
styleR IdentityS xs = xs
styleR (Fill c) xs = xs ++ [A.fill (S.stringValue c)]
styleR (Stroke c) xs = xs ++ [A.stroke (S.stringValue c)]
styleR (StrokeWidth w) xs = xs ++ [A.strokeWidth (S.stringValue w)]
styleR (s0 :*** s1) xs = styleR s1 (styleR s0 xs)

-- TODO translate
-- TODO decide on cons or concat
-- TODO HOF
-- TODO add more transform options
data Transform = IdentityT
           | Scale Double
           | Rotate Double
           | Translate Double Double
           | Transform :<+> Transform
             deriving (Read, Show)

transform :: Transform -> S.Attribute
transform t = A.transform (transformA t)

transformA :: Transform -> S.AttributeValue
transformA IdentityT = mempty
transformA (Scale f) = S.scale f f
transformA (Rotate d) = S.rotate d
transformA (Translate x y) = S.translate x y
transformA (t0 :<+> t1) = mappend (transformA t0) (transformA t1)
