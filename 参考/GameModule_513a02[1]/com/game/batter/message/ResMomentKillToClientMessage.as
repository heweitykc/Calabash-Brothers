package com.game.batter.message
{
    import net.*;

    public class ResMomentKillToClientMessage extends Message
    {
        private var _evencutatk:int;
        private var _batteratk:int;

        public function ResMomentKillToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._evencutatk);
            writeInt(this._batteratk);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._evencutatk = readInt();
            this._batteratk = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 141102;
        }// end function

        public function get evencutatk() : int
        {
            return this._evencutatk;
        }// end function

        public function set evencutatk(param1:int) : void
        {
            this._evencutatk = param1;
            return;
        }// end function

        public function get batteratk() : int
        {
            return this._batteratk;
        }// end function

        public function set batteratk(param1:int) : void
        {
            this._batteratk = param1;
            return;
        }// end function

    }
}
