import std/[net, strutils], flatty, flatty/binny, arraymancer, sequtils

proc toFlatty*[T](s: var string, x: Tensor[T]) =
  if x.size == 0:
    return
  s.addInt64(x.shape.len)
  for v in x.shape:
    s.addInt64(v)
  let byteLen = x.size * sizeof(T)
  s.setLen(s.len + byteLen)
  let dest = s[s.len - byteLen].addr
  copyMem(dest, x.toUnsafeView, byteLen)

proc fromFlatty*[T](s: string, i: var int, x: var Tensor[T]) =
  let slen = s.readInt64(i).int
  i += 8
  var shape = newSeq[int](slen)
  for j in 0..<slen:
    shape[j] = s.readInt64(i).int
    i += 8
  let size = shape.foldl(a * b)
  x = newTensor[T](shape)
  if slen > 0 and shape[0] > 0:
    copyMem(x.toUnsafeView, s[i].unsafeAddr, size * sizeof(T))
    i += sizeof(T) * size
