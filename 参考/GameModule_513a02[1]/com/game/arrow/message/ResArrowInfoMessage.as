package com.game.arrow.message
{
    import com.game.arrow.bean.*;
    import net.*;

    public class ResArrowInfoMessage extends Message
    {
        private var _notifytype:int;
        private var _arrowinfo:ArrowInfo;

        public function ResArrowInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._notifytype);
            writeBean(this._arrowinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._notifytype = readInt();
            this._arrowinfo = readBean(ArrowInfo) as ArrowInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 151101;
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

        public function get arrowinfo() : ArrowInfo
        {
            return this._arrowinfo;
        }// end function

        public function set arrowinfo(param1:ArrowInfo) : void
        {
            this._arrowinfo = param1;
            return;
        }// end function

    }
}
