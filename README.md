# NyquistMapping
For a given open-loop transfer function L(s), maps the Nyquist path in the s plane into the L(s) plane. Calculates the number of clockwise encirclements around the (-1 + 0j) point in the L(s) plane. The Nyquist path makes a loop around each L(s) integrator.

Demo:

![eqn](https://latex.codecogs.com/gif.latex?L%28s%29%20%3D%20%5Cfrac%7B100%7D%7Bs%5C%2C%5Cleft%2810%5C%2Cs-%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%2810%5C%2Cs&plus;1%7B%7D%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%28s-1%5Cright%29%5C%2C%5Cleft%28s-2%5Cright%29%5C%2C%5Cleft%28s-%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%28s&plus;1%7B%7D%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%28s-1-%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%28s-1&plus;1%7B%7D%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%28s-5%7B%7D%5Cmathrm%7Bi%7D%5Cright%29%5C%2C%5Cleft%28s&plus;5%7B%7D%5Cmathrm%7Bi%7D%5Cright%29%7D)

Pole-zero map of L(s)

![](openloopLs.png)

L(s) has 4 right half plane poles, therefore P = 4.

Mapping from s to L(s)

![](animation.gif)

Final number of clockwise encirclements is N = 2. Calculate number of right half plane (RHP) zeros in the characteristic polynomial according to Z = P + N = 6
The closed loop system is therefore unstable, because each RHP zero of the charasteristic polynomial is a RHP pole of the closed loop transfer function.

Results are consistent with pole-zero plots of the characteristic polynomial and the closed loop transfer function.
![](charpolMs.png)
![](closedloopCLs.png)
