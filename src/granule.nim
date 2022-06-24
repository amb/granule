import std/[net, strutils], flatty, flatty/binny, arraymancer, sequtils

when isMainModule:
  var tens = randomTensor[float32](64, 32, 1'f32)
  # echo tens.shape
  # echo tens.strides
  # echo tens.offset
  doAssert tens.offset == 0

  var flattybin = tens.toFlatty()
  var result = flattybin.fromFlatty(Tensor[float32])
  # echo result.shape, ", ", tens.shape
  doAssert result == tens
  doAssert result.shape == tens.shape
  # echo result[_..5, 0]
  # echo tens[_..5, 0]
