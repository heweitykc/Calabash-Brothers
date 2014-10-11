package com.game.map.message
{
    import net.*;

    public class ResNeedItemMessage extends Message
    {
        private var _type:int;
        private var _modelId:int;

        public function ResNeedItemMessage()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
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

        override public function getId() : int
        {
            return 541333;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._modelId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._modelId = readInt();
            return true;
        }// end function

    }
}
