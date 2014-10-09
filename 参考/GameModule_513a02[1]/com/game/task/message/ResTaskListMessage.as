package com.game.task.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import com.game.task.bean.*;
    import net.*;

    public class ResTaskListMessage extends Message
    {
        private var _daylyTaskacceptcount:int;
        private var _conquerTaskAcceptCount:int;
        private var _conquerTaskAcceptMaxCount:int;
        private var _devourCount:int;
        private var _DailyTask:Vector.<DailyTaskInfo>;
        private var _conqueryTask:Vector.<ConquerTaskInfo>;
        private var _mainTask:Vector.<MainTaskInfo>;
        private var _treasureHuntTask:Vector.<TreasureHuntTaskInfo>;
        private var _ableAct:Vector.<ItemInfo>;
        private var _ishasnewdailytask:int;

        public function ResTaskListMessage()
        {
            this._DailyTask = new Vector.<DailyTaskInfo>;
            this._conqueryTask = new Vector.<ConquerTaskInfo>;
            this._mainTask = new Vector.<MainTaskInfo>;
            this._treasureHuntTask = new Vector.<TreasureHuntTaskInfo>;
            this._ableAct = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._daylyTaskacceptcount);
            writeInt(this._conquerTaskAcceptCount);
            writeInt(this._conquerTaskAcceptMaxCount);
            writeInt(this._devourCount);
            writeShort(this._DailyTask.length);
            _loc_1 = 0;
            while (_loc_1 < this._DailyTask.length)
            {
                
                writeBean(this._DailyTask[_loc_1]);
                _loc_1++;
            }
            writeShort(this._conqueryTask.length);
            _loc_1 = 0;
            while (_loc_1 < this._conqueryTask.length)
            {
                
                writeBean(this._conqueryTask[_loc_1]);
                _loc_1++;
            }
            writeShort(this._mainTask.length);
            _loc_1 = 0;
            while (_loc_1 < this._mainTask.length)
            {
                
                writeBean(this._mainTask[_loc_1]);
                _loc_1++;
            }
            writeShort(this._treasureHuntTask.length);
            _loc_1 = 0;
            while (_loc_1 < this._treasureHuntTask.length)
            {
                
                writeBean(this._treasureHuntTask[_loc_1]);
                _loc_1++;
            }
            writeShort(this._ableAct.length);
            _loc_1 = 0;
            while (_loc_1 < this._ableAct.length)
            {
                
                writeBean(this._ableAct[_loc_1]);
                _loc_1++;
            }
            writeInt(this._ishasnewdailytask);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._daylyTaskacceptcount = readInt();
            this._conquerTaskAcceptCount = readInt();
            this._conquerTaskAcceptMaxCount = readInt();
            this._devourCount = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._DailyTask[_loc_1] = readBean(DailyTaskInfo) as DailyTaskInfo;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._conqueryTask[_loc_1] = readBean(ConquerTaskInfo) as ConquerTaskInfo;
                _loc_1++;
            }
            var _loc_4:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_4)
            {
                
                this._mainTask[_loc_1] = readBean(MainTaskInfo) as MainTaskInfo;
                _loc_1++;
            }
            var _loc_5:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_5)
            {
                
                this._treasureHuntTask[_loc_1] = readBean(TreasureHuntTaskInfo) as TreasureHuntTaskInfo;
                _loc_1++;
            }
            var _loc_6:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_6)
            {
                
                this._ableAct[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            this._ishasnewdailytask = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120101;
        }// end function

        public function get daylyTaskacceptcount() : int
        {
            return this._daylyTaskacceptcount;
        }// end function

        public function set daylyTaskacceptcount(param1:int) : void
        {
            this._daylyTaskacceptcount = param1;
            return;
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

        public function get DailyTask() : Vector.<DailyTaskInfo>
        {
            return this._DailyTask;
        }// end function

        public function set DailyTask(param1:Vector.<DailyTaskInfo>) : void
        {
            this._DailyTask = param1;
            return;
        }// end function

        public function get conqueryTask() : Vector.<ConquerTaskInfo>
        {
            return this._conqueryTask;
        }// end function

        public function set conqueryTask(param1:Vector.<ConquerTaskInfo>) : void
        {
            this._conqueryTask = param1;
            return;
        }// end function

        public function get mainTask() : Vector.<MainTaskInfo>
        {
            return this._mainTask;
        }// end function

        public function set mainTask(param1:Vector.<MainTaskInfo>) : void
        {
            this._mainTask = param1;
            return;
        }// end function

        public function get treasureHuntTask() : Vector.<TreasureHuntTaskInfo>
        {
            return this._treasureHuntTask;
        }// end function

        public function set treasureHuntTask(param1:Vector.<TreasureHuntTaskInfo>) : void
        {
            this._treasureHuntTask = param1;
            return;
        }// end function

        public function get ableAct() : Vector.<ItemInfo>
        {
            return this._ableAct;
        }// end function

        public function set ableAct(param1:Vector.<ItemInfo>) : void
        {
            this._ableAct = param1;
            return;
        }// end function

        public function get ishasnewdailytask() : int
        {
            return this._ishasnewdailytask;
        }// end function

        public function set ishasnewdailytask(param1:int) : void
        {
            this._ishasnewdailytask = param1;
            return;
        }// end function

    }
}
