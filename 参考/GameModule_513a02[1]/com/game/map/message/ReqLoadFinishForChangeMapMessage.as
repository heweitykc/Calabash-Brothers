package com.game.map.message
{
    import net.*;

    public class ReqLoadFinishForChangeMapMessage extends Message
    {
        private var _width:int;
        private var _height:int;

        public function ReqLoadFinishForChangeMapMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._width);
            writeInt(this._height);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._width = readInt();
            this._height = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101207;
        }// end function

        public function get width() : int
        {
            return this._width;
        }// end function

        public function set width(param1:int) : void
        {
            this._width = param1;
            return;
        }// end function

        public function get height() : int
        {
            return this._height;
        }// end function

        public function set height(param1:int) : void
        {
            this._height = param1;
            return;
        }// end function

    }
}
