package com.game.task.message
{
    import net.*;

    public class ReqRankTaskQuckFinshMessage extends Message
    {
        private var _modelId:int;

        public function ReqRankTaskQuckFinshMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120214;
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

    }
}
