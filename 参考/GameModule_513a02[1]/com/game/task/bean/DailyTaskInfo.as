package com.game.task.bean
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class DailyTaskInfo extends Bean
    {
        private var _jlId:int;
        private var _premiseId:int;
        private var _otherjlId:int;
        private var _monsterIndex:int;
        private var _permiseGoods:Vector.<TaskAttribute>;
        private var _permiseMonster:Vector.<TaskAttribute>;
        private var _permiseAchieve:Vector.<int>;
        private var _rewards:Vector.<ItemInfo>;

        public function DailyTaskInfo()
        {
            this._permiseGoods = new Vector.<TaskAttribute>;
            this._permiseMonster = new Vector.<TaskAttribute>;
            this._permiseAchieve = new Vector.<int>;
            this._rewards = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._jlId);
            writeInt(this._premiseId);
            writeInt(this._otherjlId);
            writeInt(this._monsterIndex);
            writeShort(this._permiseGoods.length);
            _loc_1 = 0;
            while (_loc_1 < this._permiseGoods.length)
            {
                
                writeBean(this._permiseGoods[_loc_1]);
                _loc_1++;
            }
            writeShort(this._permiseMonster.length);
            _loc_1 = 0;
            while (_loc_1 < this._permiseMonster.length)
            {
                
                writeBean(this._permiseMonster[_loc_1]);
                _loc_1++;
            }
            writeShort(this._permiseAchieve.length);
            _loc_1 = 0;
            while (_loc_1 < this._permiseAchieve.length)
            {
                
                writeInt(this._permiseAchieve[_loc_1]);
                _loc_1++;
            }
            writeShort(this._rewards.length);
            _loc_1 = 0;
            while (_loc_1 < this._rewards.length)
            {
                
                writeBean(this._rewards[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._jlId = readInt();
            this._premiseId = readInt();
            this._otherjlId = readInt();
            this._monsterIndex = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._permiseGoods[_loc_1] = readBean(TaskAttribute) as TaskAttribute;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._permiseMonster[_loc_1] = readBean(TaskAttribute) as TaskAttribute;
                _loc_1++;
            }
            var _loc_4:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_4)
            {
                
                this._permiseAchieve[_loc_1] = readInt();
                _loc_1++;
            }
            var _loc_5:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_5)
            {
                
                this._rewards[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            return true;
        }// end function

        public function get jlId() : int
        {
            return this._jlId;
        }// end function

        public function set jlId(param1:int) : void
        {
            this._jlId = param1;
            return;
        }// end function

        public function get premiseId() : int
        {
            return this._premiseId;
        }// end function

        public function set premiseId(param1:int) : void
        {
            this._premiseId = param1;
            return;
        }// end function

        public function get otherjlId() : int
        {
            return this._otherjlId;
        }// end function

        public function set otherjlId(param1:int) : void
        {
            this._otherjlId = param1;
            return;
        }// end function

        public function get permiseGoods() : Vector.<TaskAttribute>
        {
            return this._permiseGoods;
        }// end function

        public function set permiseGoods(param1:Vector.<TaskAttribute>) : void
        {
            this._permiseGoods = param1;
            return;
        }// end function

        public function get permiseMonster() : Vector.<TaskAttribute>
        {
            return this._permiseMonster;
        }// end function

        public function set permiseMonster(param1:Vector.<TaskAttribute>) : void
        {
            this._permiseMonster = param1;
            return;
        }// end function

        public function get permiseAchieve() : Vector.<int>
        {
            return this._permiseAchieve;
        }// end function

        public function set permiseAchieve(param1:Vector.<int>) : void
        {
            this._permiseAchieve = param1;
            return;
        }// end function

        public function get rewards() : Vector.<ItemInfo>
        {
            return this._rewards;
        }// end function

        public function set rewards(param1:Vector.<ItemInfo>) : void
        {
            this._rewards = param1;
            return;
        }// end function

        public function set monsterIndex(param1:int) : void
        {
            this._monsterIndex = param1;
            return;
        }// end function

        public function get monsterIndex() : int
        {
            return this._monsterIndex;
        }// end function

    }
}
