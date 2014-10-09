package com.game.arrow.message
{
    import com.game.arrow.bean.*;
    import net.*;

    public class ResStarInfoMessage extends Message
    {
        private var _notifytype:int;
        private var _starinfo:StarInfo;

        public function ResStarInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._notifytype);
            writeBean(this._starinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._notifytype = readInt();
            this._starinfo = readBean(StarInfo) as StarInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 151102;
        }// end function

        public function get notifytype() : int
        {
            return this._notifytype;
        }// end function

        public function set notifytype(param1:int) : void
        {
            this._notifytype = param1;
            return;
        }// end function

        public function get starinfo() : StarInfo
        {
            return this._starinfo;
        }// end function

        public function set starinfo(param1:StarInfo) : void
        {
            this._starinfo = param1;
            return;
        }// end function

    }
}
