package com.game.task.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class MainTaskInfo extends Bean
    {
        private var _modelId:int;
        private var _isFinshAction:int;
        private var _permiseGoods:Vector.<TaskAttribute>;
        private var _permiseMonster:Vector.<TaskAttribute>;
        private var _permiseAchieve:Vector.<int>;
        private var _permiseStrong:Vector.<TaskAttribute>;
        private var _permiseWear:Vector.<TaskAttribute>;
        private var _permiseElse:Vector.<TaskAttribute>;

        public function MainTaskInfo()
        {
            this._permiseGoods = new Vector.<TaskAttribute>;
            this._permiseMonster = new Vector.<TaskAttribute>;
            this._permiseAchieve = new Vector.<int>;
            this._permiseStrong = new Vector.<TaskAttribute>;
            this._permiseWear = new Vector.<TaskAttribute>;
            this._permiseElse = new Vector.<TaskAttribute>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelId);
            writeByte(this._isFinshAction);
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
            writeShort(this._permiseStrong.length);
            _loc_1 = 0;
            while (_loc_1 < this._permiseStrong.length)
            {
                
                writeBean(this._permiseStrong[_loc_1]);
                _loc_1++;
            }
            writeShort(this._permiseElse.length);
            _loc_1 = 0;
            while (_loc_1 < this._permiseElse.length)
            {
                
                writeBean(this._permiseElse[_loc_1]);
                _loc_1++;
            }
            writeShort(this._permiseWear.length);
            _loc_1 = 0;
            while (_loc_1 < this._permiseWear.length)
            {
                
                writeBean(this._permiseWear[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelId = readInt();
            this._isFinshAction = readByte();
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
            var _loc_5:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_5)
            {
                
                this._permiseStrong[_loc_2] = readBean(TaskAttribute) as TaskAttribute;
                _loc_2++;
            }
            var _loc_6:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_6)
            {
                
                this._permiseElse[_loc_2] = readBean(TaskAttribute) as TaskAttribute;
                _loc_2++;
            }
            var _loc_7:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_7)
            {
                
                this._permiseWear[_loc_2] = readBean(TaskAttribute) as TaskAttribute;
                _loc_2++;
            }
            return true;
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

        public function get isFinshAction() : int
        {
            return this._isFinshAction;
        }// end function

        public function set isFinshAction(param1:int) : void
        {
            this._isFinshAction = param1;
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

        public function get permiseStrong() : Vector.<TaskAttribute>
        {
            return this._permiseStrong;
        }// end function

        public function set permiseStrong(param1:Vector.<TaskAttribute>) : void
        {
            this._permiseStrong = param1;
            return;
        }// end function

        public function get permiseWear() : Vector.<TaskAttribute>
        {
            return this._permiseWear;
        }// end function

        public function set permiseWear(param1:Vector.<TaskAttribute>) : void
        {
            this._permiseWear = param1;
            return;
        }// end function

        public function get permiseElse() : Vector.<TaskAttribute>
        {
            return this._permiseElse;
        }// end function

        public function set permiseElse(param1:Vector.<TaskAttribute>) : void
        {
            this._permiseElse = param1;
            return;
        }// end function

    }
}
