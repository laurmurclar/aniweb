# 🏃 Get it running
Navigate to the `aniweb` directory in the terminal.

Run `stack build` to create the executable.

Then run `stack exec aniweb-exe` to run the executable and start the server.

Now when you navigate to `http://localhost:3000/` in a browser*, you should see a page where you can enter a description of a Drawing and see it rendered. There is usage instructions at the bottom of that page, but I have included them again below for convenience.

\* I used Chrome, not sure how well it will work on other browsers.
- - - -
# 👀 Usage
Enter a description in the format below and press the return key to see it as an Svg.

>[(Shape, Style, Transform)]

eg. To draw two circles and a rectangle:

>[(Circle, Fill "#f2abd2" :\*\*\* (Stroke "#000000" :\*\*\* StrokeWidth 3.0), ScaleN 1.0 0.5 :<+> Translate 1.0 2.0), (Circle, Fill "#ff0000", IdentityT), (Rect, Fill "#669b95" :\*\*\* Stroke "#FFFF00", Rotate 50.0 :<+> (Scale 0.5 :<+> Translate 2.0 0.2))]

Shapes can be:
* **Rect**
* **Circle**

Styles can be:
* **Fill String** _where the String is in the format "#RRGGBB" eg. Fill "#c0ffee"_
* **Stroke String** _where the String is in the format "#RRGGBB" eg. Stroke "#bada55"_
* **StrokeWidth Double** _eg. StrokeWidth 2.0_
* **IdentityS** _applies no styling_
* **A combination of the above styles using the compose operator :\*\*\*** _eg. Fill "#f2abd2" :\*\*\* (Stroke "#000000" :\*\*\* StrokeWidth 3.0)_

Transforms:
* **Scale Double** _scales uniformly eg. Scale 0.5_
* **ScaleN Double Double** _scales non-uniformly. The first Double is the scaling factor in the x-direction and the second is for the y-direction eg. ScaleN 2.0 0.5_
* **Rotate Double** _eg. Rotate 45.0_
* **Translate Double Double** _Again, the Doubles represent x and y respectively eg. Translate 1.5 2.0_
* **IdentityT** _applies no transforms_
* **A combination of the above transforms using the compose operator :<+>** _eg. Rotate 90.0 :<+> (Scale 0.5 :<+> Translate 2.0 0.2)_
