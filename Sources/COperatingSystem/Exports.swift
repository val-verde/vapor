#if os(Android) || os(Linux) || os(Musl)
@_exported import Glibc
#elseif os(Windows)
@_exported import MSVCRT
#else
@_exported import Darwin.C
#endif
