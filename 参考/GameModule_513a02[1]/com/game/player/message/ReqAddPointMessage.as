package com.game.player.message
{
    import net.*;

    public class ReqAddPointMessage extends Message
    {
        private var _strength:int;
        private var _vitality:int;
        private var _agile:int;
        private var _intelligence:int;
        private var _restPlusPoint:int;

        public function ReqAddPointMessage()
        {
            return;
        }// end function

        public function get strength() : int
        {
            return this._strength;
        }// end function

        public function set strength(param1:int) : void
        {
            this._strength = param1;
            return;
        }// end function

        public function get vitality() : int
        {
            return this._vitality;
        }// end function

        public function set vitality(param1:int) : void
        {
            this._vitality = param1;
            return;
        }// end function

        public function get agile() : int
        {
            return this._agile;
        }// end function

        public function set agile(param1:int) : void
        {
            this._agile = param1;
            return;
        }// end function

        public function get intelligence() : int
        {
            return this._intelligence;
        }// end function

        public function set intelligence(param1:int) : void
        {
            this._intelligence = param1;
            return;
        }// end function

        public function get restPlusPoint() : int
        {
            return this._restPlusPoint;
        }// end function

        public function set restPlusPoint(param1:int) : void
        {
            this._restPlusPoint = this.restPlusPoint;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._strength);
            writeInt(this._vitality);
            writeInt(this._agile);
            writeInt(this._intelligence);
            writeInt(this._restPlusPoint);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._strength = readInt();
            this._vitality = readInt();
            this._agile = readInt();
            this._intelligence = readInt();
            this._restPlusPoint = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103890;
        }// end function

    }
}
