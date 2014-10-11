package com.game.player.message
{
    import net.*;

    public class ResPlayerChangeJobMessage extends Message
    {
        private var _job:int;
        private var _addbase:int;
        private var _otherParms:String;

        public function ResPlayerChangeJobMessage()
        {
            return;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set addbase(param1:int) : void
        {
            this._addbase = param1;
            return;
        }// end function

        public function get addbase() : int
        {
            return this._addbase;
        }// end function

        public function set otherParms(param1:String) : void
        {
            this._otherParms = param1;
            return;
        }// end function

        public function get otherParms() : String
        {
            return this._otherParms;
        }// end function

        override public function getId() : int
        {
            return 510001;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._job);
            writeInt(this._addbase);
            writeString(this._otherParms);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._job = readByte();
            this._addbase = readInt();
            this._otherParms = readString();
            return true;
        }// end function

    }
}
