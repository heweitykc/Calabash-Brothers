package com.game.task.bean
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ConquerTaskInfo extends Bean
    {
        private var _id:long;
        private var _modelId:int;
        private var _permiseGoods:Vector.<TaskAttribute>;
        private var _permiseMonster:Vector.<TaskAttribute>;
        private var _permiseAchieve:Vector.<int>;
        private var _rewardsExp:int;
        private var _rewardsCopper:int;
        private var _rewardsZQ:int;
        private var _rewardsSW:int;
        private var _rewardsBindGold:int;
        private var _rewards:Vector.<ItemInfo>;

        public function ConquerTaskInfo()
        {
            this._permiseGoods = new Vector.<TaskAttribute>;
            this._permiseMonster = new Vector.<TaskAttribute>;
            this._permiseAchieve = new Vector.<int>;
            this._rewards = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._id);
            writeInt(this._modelId);
            writeShort(this._permiseGoods.length);
            var _loc_1:* = 0;
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
            writeInt(this._rewardsExp);
            writeInt(this._rewardsCopper);
            writeInt(this._rewardsZQ);
            writeInt(this._rewardsSW);
            writeInt(this._rewardsBindGold);
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
            this._id = readLong();
            this._modelId = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._permiseGoods[_loc_2] = readBean(TaskAttribute) as TaskAttribute;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._permiseMonster[_loc_2] = readBean(TaskAttribute) as TaskAttribute;
                _loc_2++;
            }
            var _loc_4:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this._permiseAchieve[_loc_2] = readInt();
                _loc_2++;
            }
            this._rewardsExp = readInt();
            this._rewardsCopper = readInt();
            this._rewardsZQ = readInt();
            this._rewardsSW = readInt();
            this._rewardsBindGold = readInt();
            var _loc_5:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_5)
            {
                
                this._rewards[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get id() : long
        {
            return this._id;
        }// end function

        public function set id(param1:long) : void
        {
            this._id = param1;
            return;
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

        public function get rewardsExp() : int
        {
            return this._rewardsExp;
        }// end function

        public function set rewardsExp(param1:int) : void
        {
            this._rewardsExp = param1;
            return;
        }// end function

        public function get rewardsCopper() : int
        {
            return this._rewardsCopper;
        }// end function

        public function set rewardsCopper(param1:int) : void
        {
            this._rewardsCopper = param1;
            return;
        }// end function

        public function get rewardsZQ() : int
        {
            return this._rewardsZQ;
        }// end function

        public function set rewardsZQ(param1:int) : void
        {
            this._rewardsZQ = param1;
            return;
        }// end function

        public function get rewardsSW() : int
        {
            return this._rewardsSW;
        }// end function

        public function set rewardsSW(param1:int) : void
        {
            this._rewardsSW = param1;
            return;
        }// end function

        public function get rewardsBindGold() : int
        {
            return this._rewardsBindGold;
        }// end function

        public function set rewardsBindGold(param1:int) : void
        {
            this._rewardsBindGold = param1;
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

    }
}
