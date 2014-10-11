package com.game.arrow.message
{
    import com.game.arrow.bean.*;
    import net.*;

    public class ResBowInfoMessage extends Message
    {
        private var _notifytype:int;
        private var _bowinfo:BowInfo;

        public function ResBowInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._notifytype);
            writeBean(this._bowinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._notifytype = readInt();
            this._bowinfo = readBean(BowInfo) as BowInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 151103;
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

        public function get bowinfo() : BowInfo
        {
            return this._bowinfo;
        }// end function

        public function set bowinfo(param1:BowInfo) : void
        {
            this._bowinfo = param1;
            return;
        }// end function

    }
}
