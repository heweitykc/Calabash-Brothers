package com.game.guard.message
{
    import net.*;

    public class ResNpcBloodMessage extends Message
    {
        private var _modelId:int;
        private var _hp:int;
        private var _maxhp:int;

        public function ResNpcBloodMessage()
        {
            return;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
            return;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set maxhp(param1:int) : void
        {
            this._maxhp = param1;
            return;
        }// end function

        public function get maxhp() : int
        {
            return this._maxhp;
        }// end function

        override public function getId() : int
        {
            return 600019;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelId);
            writeInt(this._hp);
            writeInt(this._maxhp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelId = readInt();
            this._hp = readInt();
            this._maxhp = readInt();
            return true;
        }// end function

    }
}
