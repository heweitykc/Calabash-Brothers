package com.game.zones.message
{
    import net.*;

    public class ResTowerRewardSurplusMessage extends Message
    {
        private var _surplus:int;
        private var _golds:int;
        private var _money:int;

        public function ResTowerRewardSurplusMessage()
        {
            return;
        }// end function

        public function set surplus(param1:int) : void
        {
            this._surplus = param1;
            return;
        }// end function

        public function get surplus() : int
        {
            return this._surplus;
        }// end function

        public function set golds(param1:int) : void
        {
            this._golds = param1;
            return;
        }// end function

        public function get golds() : int
        {
            return this._golds;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 600000;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._surplus);
            writeInt(this._golds);
            writeInt(this._money);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._surplus = readInt();
            this._golds = readInt();
            this._money = readInt();
            return true;
        }// end function

    }
}
