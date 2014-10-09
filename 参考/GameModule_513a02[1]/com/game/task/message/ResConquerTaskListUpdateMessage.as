package com.game.task.message
{
    import __AS3__.vec.*;
    import com.game.task.bean.*;
    import net.*;

    public class ResConquerTaskListUpdateMessage extends Message
    {
        private var _conquerTaskAcceptCount:int;
        private var _conquerTaskAcceptMaxCount:int;
        private var _devourCount:int;
        private var _task:Vector.<ConquerTaskInfo>;

        public function ResConquerTaskListUpdateMessage()
        {
            this._task = new Vector.<ConquerTaskInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._conquerTaskAcceptCount);
            writeInt(this._conquerTaskAcceptMaxCount);
            writeInt(this._devourCount);
            writeShort(this._task.length);
            _loc_1 = 0;
            while (_loc_1 < this._task.length)
            {
                
                writeBean(this._task[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._conquerTaskAcceptCount = readInt();
            this._conquerTaskAcceptMaxCount = readInt();
            this._devourCount = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._task[_loc_1] = readBean(ConquerTaskInfo) as ConquerTaskInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 120109;
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

        public function get task() : Vector.<ConquerTaskInfo>
        {
            return this._task;
        }// end function

        public function set task(param1:Vector.<ConquerTaskInfo>) : void
        {
            this._task = param1;
            return;
        }// end function

    }
}
