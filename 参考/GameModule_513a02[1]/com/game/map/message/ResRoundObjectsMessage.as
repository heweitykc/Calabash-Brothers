package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.map.bean.*;
    import com.game.summonpet.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundObjectsMessage extends Message
    {
        private var _player:Vector.<CSPlayerInfo>;
        private var _playerIds:Vector.<long>;
        private var _monster:Vector.<CSMonsterInfo>;
        private var _monstersIds:Vector.<long>;
        private var _goods:Vector.<DropGoodsInfo>;
        private var _goodsIds:Vector.<long>;
        private var _pets:Vector.<PetInfo>;
        private var _petIds:Vector.<long>;
        private var _npcs:Vector.<NpcInfo>;
        private var _npcid:Vector.<long>;
        private var _Effect:Vector.<EffectInfo>;
        private var _effectid:Vector.<long>;
        private var _summonpets:Vector.<SummonPetInfo>;
        private var _summonpetIds:Vector.<long>;

        public function ResRoundObjectsMessage()
        {
            this._player = new Vector.<CSPlayerInfo>;
            this._playerIds = new Vector.<long>;
            this._monster = new Vector.<CSMonsterInfo>;
            this._monstersIds = new Vector.<long>;
            this._goods = new Vector.<DropGoodsInfo>;
            this._goodsIds = new Vector.<long>;
            this._pets = new Vector.<PetInfo>;
            this._petIds = new Vector.<long>;
            this._npcs = new Vector.<NpcInfo>;
            this._npcid = new Vector.<long>;
            this._Effect = new Vector.<EffectInfo>;
            this._effectid = new Vector.<long>;
            this._summonpets = new Vector.<SummonPetInfo>;
            this._summonpetIds = new Vector.<long>;
            return;
        }// end function

        public function set player(param1:Vector.<CSPlayerInfo>) : void
        {
            this._player = param1;
            return;
        }// end function

        public function get player() : Vector.<CSPlayerInfo>
        {
            return this._player;
        }// end function

        public function set playerIds(param1:Vector.<long>) : void
        {
            this._playerIds = param1;
            return;
        }// end function

        public function get playerIds() : Vector.<long>
        {
            return this._playerIds;
        }// end function

        public function set monster(param1:Vector.<CSMonsterInfo>) : void
        {
            this._monster = param1;
            return;
        }// end function

        public function get monster() : Vector.<CSMonsterInfo>
        {
            return this._monster;
        }// end function

        public function set monstersIds(param1:Vector.<long>) : void
        {
            this._monstersIds = param1;
            return;
        }// end function

        public function get monstersIds() : Vector.<long>
        {
            return this._monstersIds;
        }// end function

        public function set goods(param1:Vector.<DropGoodsInfo>) : void
        {
            this._goods = param1;
            return;
        }// end function

        public function get goods() : Vector.<DropGoodsInfo>
        {
            return this._goods;
        }// end function

        public function set goodsIds(param1:Vector.<long>) : void
        {
            this._goodsIds = param1;
            return;
        }// end function

        public function get goodsIds() : Vector.<long>
        {
            return this._goodsIds;
        }// end function

        public function set pets(param1:Vector.<PetInfo>) : void
        {
            this._pets = param1;
            return;
        }// end function

        public function get pets() : Vector.<PetInfo>
        {
            return this._pets;
        }// end function

        public function set petIds(param1:Vector.<long>) : void
        {
            this._petIds = param1;
            return;
        }// end function

        public function get petIds() : Vector.<long>
        {
            return this._petIds;
        }// end function

        public function set npcs(param1:Vector.<NpcInfo>) : void
        {
            this._npcs = param1;
            return;
        }// end function

        public function get npcs() : Vector.<NpcInfo>
        {
            return this._npcs;
        }// end function

        public function set npcid(param1:Vector.<long>) : void
        {
            this._npcid = param1;
            return;
        }// end function

        public function get npcid() : Vector.<long>
        {
            return this._npcid;
        }// end function

        public function set Effect(param1:Vector.<EffectInfo>) : void
        {
            this._Effect = param1;
            return;
        }// end function

        public function get Effect() : Vector.<EffectInfo>
        {
            return this._Effect;
        }// end function

        public function set effectid(param1:Vector.<long>) : void
        {
            this._effectid = param1;
            return;
        }// end function

        public function get effectid() : Vector.<long>
        {
            return this._effectid;
        }// end function

        public function set summonpets(param1:Vector.<SummonPetInfo>) : void
        {
            this._summonpets = param1;
            return;
        }// end function

        public function get summonpets() : Vector.<SummonPetInfo>
        {
            return this._summonpets;
        }// end function

        public function set summonpetIds(param1:Vector.<long>) : void
        {
            this._summonpetIds = param1;
            return;
        }// end function

        public function get summonpetIds() : Vector.<long>
        {
            return this._summonpetIds;
        }// end function

        override public function getId() : int
        {
            return 101125;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._player.length);
            _loc_1 = 0;
            while (_loc_1 < this._player.length)
            {
                
                writeBean(this._player[_loc_1]);
                _loc_1++;
            }
            writeShort(this._playerIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._playerIds.length)
            {
                
                writeLong(this._playerIds[_loc_1]);
                _loc_1++;
            }
            writeShort(this._monster.length);
            _loc_1 = 0;
            while (_loc_1 < this._monster.length)
            {
                
                writeBean(this._monster[_loc_1]);
                _loc_1++;
            }
            writeShort(this._monstersIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._monstersIds.length)
            {
                
                writeLong(this._monstersIds[_loc_1]);
                _loc_1++;
            }
            writeShort(this._goods.length);
            _loc_1 = 0;
            while (_loc_1 < this._goods.length)
            {
                
                writeBean(this._goods[_loc_1]);
                _loc_1++;
            }
            writeShort(this._goodsIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._goodsIds.length)
            {
                
                writeLong(this._goodsIds[_loc_1]);
                _loc_1++;
            }
            writeShort(this._pets.length);
            _loc_1 = 0;
            while (_loc_1 < this._pets.length)
            {
                
                writeBean(this._pets[_loc_1]);
                _loc_1++;
            }
            writeShort(this._petIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._petIds.length)
            {
                
                writeLong(this._petIds[_loc_1]);
                _loc_1++;
            }
            writeShort(this._npcs.length);
            _loc_1 = 0;
            while (_loc_1 < this._npcs.length)
            {
                
                writeBean(this._npcs[_loc_1]);
                _loc_1++;
            }
            writeShort(this._npcid.length);
            _loc_1 = 0;
            while (_loc_1 < this._npcid.length)
            {
                
                writeLong(this._npcid[_loc_1]);
                _loc_1++;
            }
            writeShort(this._Effect.length);
            _loc_1 = 0;
            while (_loc_1 < this._Effect.length)
            {
                
                writeBean(this._Effect[_loc_1]);
                _loc_1++;
            }
            writeShort(this._effectid.length);
            _loc_1 = 0;
            while (_loc_1 < this._effectid.length)
            {
                
                writeLong(this._effectid[_loc_1]);
                _loc_1++;
            }
            writeShort(this._summonpets.length);
            _loc_1 = 0;
            while (_loc_1 < this._summonpets.length)
            {
                
                writeBean(this._summonpets[_loc_1]);
                _loc_1++;
            }
            writeShort(this._summonpetIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._summonpetIds.length)
            {
                
                writeLong(this._summonpetIds[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._player[_loc_2] = readBean(CSPlayerInfo) as CSPlayerInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._playerIds[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_4:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this._monster[_loc_2] = readBean(CSMonsterInfo) as CSMonsterInfo;
                _loc_2++;
            }
            var _loc_5:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_5)
            {
                
                this._monstersIds[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_6:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_6)
            {
                
                this._goods[_loc_2] = readBean(DropGoodsInfo) as DropGoodsInfo;
                _loc_2++;
            }
            var _loc_7:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_7)
            {
                
                this._goodsIds[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_8:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_8)
            {
                
                this._pets[_loc_2] = readBean(PetInfo) as PetInfo;
                _loc_2++;
            }
            var _loc_9:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_9)
            {
                
                this._petIds[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_10:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_10)
            {
                
                this._npcs[_loc_2] = readBean(NpcInfo) as NpcInfo;
                _loc_2++;
            }
            var _loc_11:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_11)
            {
                
                this._npcid[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_12:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_12)
            {
                
                this._Effect[_loc_2] = readBean(EffectInfo) as EffectInfo;
                _loc_2++;
            }
            var _loc_13:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_13)
            {
                
                this._effectid[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_14:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_14)
            {
                
                this._summonpets[_loc_2] = readBean(SummonPetInfo) as SummonPetInfo;
                _loc_2++;
            }
            var _loc_15:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_15)
            {
                
                this._summonpetIds[_loc_2] = readLong();
                _loc_2++;
            }
            return true;
        }// end function

    }
}
