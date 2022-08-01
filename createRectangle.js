function add() {
  let rectElem = document.getElementById("rect");
  const EDGEDIM = 512;
  const rectElemArr = [];
  if (rectElem) {
    if (rectElem.parentNode) {
      rectElem.parentNode.removeChild(rectElem);
    }
  }
  if (document.getElementById("test").value != "") {
    const nRect = parseInt(document.getElementById("test").value) << 1;
    const node = document.createElement("img");
    node.id = "rect";
    const prefix = `<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="${EDGEDIM}" height="${EDGEDIM}">`;
    const postfix = "</svg>";
    let rectTag = "";
    const nRectHalf = nRect >> 1;
    const rectData = {
      xLim: nRectHalf,
      yLim: nRectHalf,
      height: EDGEDIM / nRectHalf,
      width: EDGEDIM / nRectHalf,
    };
    for (let i = 0; i < rectData.xLim; i++) {
      for (let j = 0; j < rectData.yLim; j++) {
        const randRGB = [
          parseInt(Math.random() * 255),
          parseInt(Math.random() * 255),
          parseInt(Math.random() * 255),
        ];
        rectTag = `<rect x="${j * rectData.width}" y="${
          i * rectData.height
        }" width="${rectData.width}" height="${
          rectData.height
        }" style="fill:rgb(${randRGB[0]},${randRGB[1]},${
          randRGB[2]
        });stroke:black;stroke-width:1;opacity:0.8" />`;
        rectElemArr.push(rectTag);
      }
    }
    const svgText = `<text fill="#FFFFFF" font-size="60" font-family="Verdana" x="50%" y="50%" dominant-baseline="middle" text-anchor="middle">${nRectHalf}x${nRectHalf}</text>`;
    const svgStr = prefix + rectElemArr.join("") + svgText + postfix;
    console.log(svgStr);
    const svgBase64 = window.btoa(svgStr);
    console.log(svgBase64);
    const svgPrefix = "data:image/svg+xml;base64,";
    node.src = svgPrefix + svgBase64;
    document.getElementById("container").appendChild(node);
  }
}
