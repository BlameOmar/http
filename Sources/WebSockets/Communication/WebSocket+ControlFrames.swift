import struct Base.Bytes

/*
     'close' included in Model file to ensure safety while interacting with sensitive variables
*/
extension WebSocket {
    public func ping(_ payload: Bytes = []) throws {
        let header = Frame.Header(
            fin: true,
            rsv1: false,
            rsv2: false,
            rsv3: false,
            opCode: .ping,
            isMasked: mode.maskOutgoingMessages,
            payloadLength: UInt64(payload.count),
            maskingKey: mode.makeKey()
        )
        let msg = Frame(header: header, payload: payload)
        try send(msg)
    }

    /**
         If we receive a .ping, we must .pong identical data

         Applications may opt to send unsolicited .pong messages as a sort of keep awake heart beat
    */
    public func pong(_ payload: Bytes = []) throws {
        let header = Frame.Header(
            fin: true,
            rsv1: false,
            rsv2: false,
            rsv3: false,
            opCode: .pong,
            isMasked: mode.maskOutgoingMessages,
            payloadLength: UInt64(payload.count),
            maskingKey: mode.makeKey()
        )
        let msg = Frame(header: header, payload: payload)
        try send(msg)
    }
}
