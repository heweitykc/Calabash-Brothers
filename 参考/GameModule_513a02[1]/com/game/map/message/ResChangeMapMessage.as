package com.game.map.message
{
    import net.*;

    public class ResChangeMapMessage extends Message
    {
        private var _type:int;
        private var _mapId:int;

        public function ResChangeMapMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._mapId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._mapId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101117;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
        }// end function

    }
}
