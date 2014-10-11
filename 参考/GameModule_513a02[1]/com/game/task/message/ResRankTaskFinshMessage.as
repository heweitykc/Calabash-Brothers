package com.game.task.message
{
    import net.*;

    public class ResRankTaskFinshMessage extends Message
    {
        private var _modelId:int;
        private var _finshType:int;

        public function ResRankTaskFinshMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelId);
            writeInt(this._finshType);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelId = readInt();
            this._finshType = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120116;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get finshType() : int
        {
            return this._finshType;
        }// end function

        public function set finshType(param1:int) : void
        {
            this._finshType = param1;
            return;
        }// end function

    }
}
