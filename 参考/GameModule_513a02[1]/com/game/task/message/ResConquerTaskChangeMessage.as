package com.game.task.message
{
    import com.game.task.bean.*;
    import net.*;

    public class ResConquerTaskChangeMessage extends Message
    {
        private var _conquerTaskAcceptCount:int;
        private var _conquerTaskAcceptMaxCount:int;
        private var _devourCount:int;
        private var _task:ConquerTaskInfo;

        public function ResConquerTaskChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._conquerTaskAcceptCount);
            writeInt(this._conquerTaskAcceptMaxCount);
            writeInt(this._devourCount);
            writeBean(this._task);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._conquerTaskAcceptCount = readInt();
            this._conquerTaskAcceptMaxCount = readInt();
            this._devourCount = readInt();
            this._task = readBean(ConquerTaskInfo) as ConquerTaskInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120106;
        }// end function

        public function get conquerTaskAcceptCount() : int
        {
            return this._conquerTaskAcceptCount;
        }// end function

        public function set conquerTaskAcceptCount(param1:int) : void
        {
            this._conquerTaskAcceptCount = param1;
            return;
        }// end function

        public function get conquerTaskAcceptMaxCount() : int
        {
            return this._conquerTaskAcceptMaxCount;
        }// end function

        public function set conquerTaskAcceptMaxCount(param1:int) : void
        {
            this._conquerTaskAcceptMaxCount = param1;
            return;
        }// end function

        public function get devourCount() : int
        {
            return this._devourCount;
        }// end function

        public function set devourCount(param1:int) : void
        {
            this._devourCount = param1;
            return;
        }// end function

        public function get task() : ConquerTaskInfo
        {
            return this._task;
        }// end function

        public function set task(param1:ConquerTaskInfo) : void
        {
            this._task = param1;
            return;
        }// end function

    }
}
