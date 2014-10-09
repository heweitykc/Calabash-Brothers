package com.game.bosshome.message
{
    import net.*;

    public class ResOpenBossHomeMessage extends Message
    {
        private var _count:int;

        public function ResOpenBossHomeMessage()
        {
            return;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        override public function getId() : int
        {
            return 543001;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._count = readInt();
            return true;
        }// end function

    }
}
