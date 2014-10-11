package com.game.map.message
{
    import net.*;

    public class ReqGoldMapTransMessage extends Message
    {
        private var _mapId:int;
        private var _line:int;

        public function ReqGoldMapTransMessage()
        {
            return;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._mapId);
            writeInt(this._line);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mapId = readInt();
            this._line = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101210;
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
