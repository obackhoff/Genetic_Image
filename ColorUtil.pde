class ColorUtil{

  float[] lab2rgb(float[] lab){
    float y = (lab[0] + 16) / 116.0;
    float x = lab[1] / 500.0 + y;
    float z = y - lab[2] / 200.0;
    float r, g, b;
  
    x = 0.95047 * ((x * x * x > 0.008856) ? x * x * x : (x - 16/116.0) / 7.787);
    y = 1.00000 * ((y * y * y > 0.008856) ? y * y * y : (y - 16/116.0) / 7.787);
    z = 1.08883 * ((z * z * z > 0.008856) ? z * z * z : (z - 16/116.0) / 7.787);
  
    r = x *  3.2406 + y * -1.5372 + z * -0.4986;
    g = x * -0.9689 + y *  1.8758 + z *  0.0415;
    b = x *  0.0557 + y * -0.2040 + z *  1.0570;
  
    r = (r > 0.0031308) ? (1.055 * pow(r, 1/2.4) - 0.055) : 12.92 * r;
    g = (g > 0.0031308) ? (1.055 * pow(g, 1/2.4) - 0.055) : 12.92 * g;
    b = (b > 0.0031308) ? (1.055 * pow(b, 1/2.4) - 0.055) : 12.92 * b;
    
    float[] rgb = {max(0, min(1, r)) * 255.0, max(0, min(1, g)) * 255.0, max(0, min(1, b)) * 255.0};
    return rgb;
  }  


  float[] rgb2lab(float[] rgb){
    float r = rgb[0] / 255.0;
    float g = rgb[1] / 255.0;
    float b = rgb[2] / 255.0;
    float x, y, z;
  
    r = (r > 0.04045) ? pow((r + 0.055) / 1.055, 2.4) : r / 12.92;
    g = (g > 0.04045) ? pow((g + 0.055) / 1.055, 2.4) : g / 12.92;
    b = (b > 0.04045) ? pow((b + 0.055) / 1.055, 2.4) : b / 12.92;
  
    x = (r * 0.4124 + g * 0.3576 + b * 0.1805) / 0.95047;
    y = (r * 0.2126 + g * 0.7152 + b * 0.0722) / 1.00000;
    z = (r * 0.0193 + g * 0.1192 + b * 0.9505) / 1.08883;
  
    x = (x > 0.008856) ? pow(x, 1/3.0) : (7.787 * x) + 16/116.0;
    y = (y > 0.008856) ? pow(y, 1/3.0) : (7.787 * y) + 16/116.0;
    z = (z > 0.008856) ? pow(z, 1/3.0) : (7.787 * z) + 16/116.0;
   
    float[] lab = {(116.0 * y) - 16, 500.0 * (x - y), 200.0 * (y - z)};
    return lab;
  }

// calculate the perceptual distance between colors in CIELAB
// https://github.com/THEjoezack/ColorMine/blob/master/ColorMine/ColorSpaces/Comparisons/Cie94Comparison.cs

  float deltaE(float[] labA, float[] labB){
    float deltaL = labA[0] - labB[0];
    float deltaA = labA[1] - labB[1];
    float deltaB = labA[2] - labB[2];
    float c1 = sqrt(labA[1] * labA[1] + labA[2] * labA[2]);
    float c2 = sqrt(labB[1] * labB[1] + labB[2] * labB[2]);
    float deltaC = c1 - c2;
    float deltaH = deltaA * deltaA + deltaB * deltaB - deltaC * deltaC;
    deltaH = deltaH < 0 ? 0 : sqrt(deltaH);
    float sc = 1.0 + 0.045 * c1;
    float sh = 1.0 + 0.015 * c1;
    float deltaLKlsl = deltaL / (1.0);
    float deltaCkcsc = deltaC / (sc);
    float deltaHkhsh = deltaH / (sh);
    float i = deltaLKlsl * deltaLKlsl + deltaCkcsc * deltaCkcsc + deltaHkhsh * deltaHkhsh;
    return i < 0 ? 0 : sqrt(i);
  }

}