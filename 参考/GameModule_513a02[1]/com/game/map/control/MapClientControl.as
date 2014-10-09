package com.game.map.control
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.path.*;
    import com.game.backpack.bean.*;
    import com.game.buff.bean.*;
    import com.game.chat.bean.*;
    import com.game.dragonking.control.*;
    import com.game.fight.bean.*;
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import com.game.fight.model.*;
    import com.game.horse.control.*;
    import com.game.horse.message.*;
    import com.game.map.bean.*;
    import com.game.map.message.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.player.control.*;
    import com.game.player.message.*;
    import com.game.prompt.control.*;
    import com.game.prompt.message.*;
    import com.game.role.*;
    import com.game.shortcut.bean.*;
    import com.game.shortcut.control.*;
    import com.game.shortcut.message.*;
    import com.game.structs.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import interfaces.role.*;

    public class MapClientControl extends Object
    {
        private var lowId:int;
        private var _monNum:int;
        private var _curClientZoneControl:IClientZoneControl;
        private var preMap:int;
        private var preX:int;
        private var preY:int;
        public var lowestHp:int;
        public var HIT_PLUS:int = 0;
        public var HIT_RANGE_PLUS:int = 0;
        public var _fakeBuffList:Array;
        private var _mapId:int;
        private static var instance:MapClientControl;

        public function MapClientControl()
        {
            return;
        }// end function

        public function clientChangeMap(param1:int) : void
        {
            if (param1 == MapObj.getInstance().mapID)
            {
                return;
            }
            this._mapId = param1;
            this.preMap = MapObj.getInstance().mapID;
            this.preX = RoleList.getInstance().player._x;
            this.preY = RoleList.getInstance().player._y;
            MapObj.getInstance().mapID = param1;
            UserObj.getInstance().playerInfo.mapId = param1;
            MapControl.getInstance().isClientMove = true;
            MapControl.getInstance().isClientPick = true;
            var _loc_2:* = new ResEnterMapMessage();
            _loc_2.pos = new Position();
            var _loc_3:* = MapCfgObj.getInstance().getMap(param1);
            var _loc_4:* = MapUtils.tile2Coo([_loc_3.dieX, _loc_3.dieY]);
            _loc_2.pos.x = _loc_4[0];
            _loc_2.pos.y = _loc_4[1];
            _loc_2.line = UserObj.getInstance().line;
            MapControl.getInstance().enterMapHandler(_loc_2);
            ZonesControl.getInstance().reqChangeClientZone(param1, 0, param1);
            if (MapControl.getInstance().currentGameScene)
            {
                MapControl.getInstance().currentGameScene.disableEnterFrame();
            }
            if (param1 == Params.CLIENT_ZONES_SKE_KING_ID)
            {
                this._curClientZoneControl = ClientZonesSkeletonKingControl.getInstance();
                this._curClientZoneControl.enterZone();
            }
            if (param1 == Params.CLIENT_ZONES_DRAGON_KING)
            {
                this._curClientZoneControl = DragonKingController.getInstance();
                this._curClientZoneControl.enterZone();
            }
            return;
        }// end function

        public function changeRideState() : void
        {
            var _loc_1:* = new ResRidingStateMessage();
            _loc_1.playerid = UserObj.getInstance().playerInfo.personId;
            _loc_1.curlayer = 0;
            _loc_1.status = 0;
            HorseControl.getInstance().ResRidingStateHandler(_loc_1);
            return;
        }// end function

        public function dealDrop(param1:DropIcon) : void
        {
            if (this._mapId == Params.CLIENT_ZONES_DRAGON_KING)
            {
                DragonKingFightControl.getInstance().dealDrop(param1);
            }
            return;
        }// end function

        public function clientBackMap() : void
        {
            if (MapObj.getInstance().mapID == Params.CLIENT_ZONES_SKE_KING_ID)
            {
                ZonesControl.getInstance().reqChangeClientZone(Params.CLIENT_ZONES_SKE_KING_ID, 1, Params.CLIENT_ZONES_SKE_KING_ID);
            }
            if (MapObj.getInstance().mapID == Params.CLIENT_ZONES_DRAGON_KING)
            {
                ZonesControl.getInstance().reqChangeClientZone(Params.CLIENT_ZONES_DRAGON_KING, 1, MapObj.getInstance().mapID);
            }
            if (this._curClientZoneControl)
            {
                this._curClientZoneControl.exitZone();
            }
            return;
        }// end function

        public function createClientMonster(param1:int, param2:int = 1) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = MapCfgObj.getInstance().getClientMonsterByMapId(param1);
            if (_loc_3 && _loc_3.length)
            {
                for each (_loc_4 in _loc_3[param2])
                {
                    
                    _loc_4.personId = this.getClientId();
                    MapControl.getInstance().addClientMonsterByInfo(_loc_4);
                    var _loc_7:* = this;
                    var _loc_8:* = this._monNum + 1;
                    _loc_7._monNum = _loc_8;
                }
            }
            return;
        }// end function

        public function addClientSkill(param1:int, param2:int) : void
        {
            var _loc_3:* = new ShortCutAddMessage();
            var _loc_4:* = new ShortCutInfo();
            _loc_4.shortcutGrid = param2;
            _loc_4.shortcutSourceModel = param1;
            _loc_4.shortcutType = 2;
            _loc_4.shortcutId = long.fromNumber(4);
            _loc_3.shortcut = _loc_4;
            ShortcutControl.getInstance().shortCutAddHandle(_loc_3);
            return;
        }// end function

        public function removeClientSkill(param1:int) : void
        {
            var _loc_2:* = new ShortCutRemoveMessage();
            _loc_2.shortcutGrid = param1;
            ShortcutControl.getInstance().shortCutRemoveHandle(_loc_2);
            return;
        }// end function

        public function createAttackResult(param1:int, param2:long, param3:long, param4:int, param5:int, param6:int = 0) : void
        {
            var _loc_7:* = new ResAttackResultMessage();
            var _loc_8:* = new AttackResultInfo();
            _loc_8.sourceId = param2;
            _loc_8.fightResult = FightResultType.SUCCESS;
            _loc_8.entityId = param3;
            _loc_8.skillId = param1;
            _loc_8.damage = param4;
            _loc_8.currentHP = param5;
            _loc_8.fightSpecialRes = param6;
            _loc_7.state = _loc_8;
            FightControl.getInstance().attackResultHandler(_loc_7);
            return;
        }// end function

        public function createMonDrop(param1:Array, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_7:* = param1.length;
            var _loc_9:* = 0;
            while (_loc_9 < _loc_7)
            {
                
                _loc_8 = new PropInfo();
                _loc_8.convByCfg(param1[_loc_9]);
                if (!_loc_8.isUseForJob(UserObj.getInstance().playerInfo.job))
                {
                }
                else
                {
                    _loc_5 = new ResRoundGoodsMessage();
                    _loc_6 = new DropGoodsInfo();
                    _loc_6.ownerId = new Vector.<long>;
                    _loc_6.dropGoodsId = this.getClientId();
                    _loc_6.itemModelId = param1[_loc_9];
                    _loc_6.num = 1;
                    _loc_6.dropTime = new long(0, 0);
                    _loc_6.itemModelId = param1[_loc_9];
                    _loc_6.x = param3;
                    _loc_6.y = param4;
                    _loc_5.goods = _loc_6;
                    MapControl.getInstance().dropRoundGoods(_loc_5);
                }
                _loc_9++;
            }
            if (param2 > 0)
            {
                _loc_5 = new ResRoundGoodsMessage();
                _loc_6 = new DropGoodsInfo();
                _loc_6.ownerId = new Vector.<long>;
                _loc_6.dropGoodsId = this.getClientId();
                _loc_6.num = param2;
                _loc_6.dropTime = new long(0, 0);
                if (param2 > 0 && param2 < 1000)
                {
                    _loc_6.itemModelId = 700036;
                }
                else if (param2 >= 1000 && param2 < 10000)
                {
                    _loc_6.itemModelId = 700035;
                }
                else
                {
                    _loc_6.itemModelId = 700034;
                }
                _loc_6.x = param3;
                _loc_6.y = param4;
                _loc_5.goods = _loc_6;
                MapControl.getInstance().dropRoundGoods(_loc_5);
            }
            return;
        }// end function

        public function addWeapon(param1:int, param2:int, param3:int = 13, param4:long = null) : void
        {
            var _loc_5:* = new ResWeaponChangeMessage();
            _loc_5.personId = param4 ? (param4) : (UserObj.getInstance().playerInfo.personId);
            _loc_5.weaponStreng = param3;
            _loc_5.pos = param2;
            _loc_5.weaponId = param1;
            MapControl.getInstance().weaponChangeHandler(_loc_5);
            return;
        }// end function

        public function addWing(param1:int, param2:int, param3:int = 13, param4:long = null) : void
        {
            var _loc_5:* = new ResWingChangeMessage();
            _loc_5.personId = param4 ? (param4) : (UserObj.getInstance().playerInfo.personId);
            _loc_5.weaponStreng = param3;
            _loc_5.pos = param2;
            _loc_5.weaponId = param1;
            MapControl.getInstance().wingChangeHandler(_loc_5);
            return;
        }// end function

        public function removeWeapon(param1:int, param2:int = 13, param3:long = null) : void
        {
            var _loc_4:* = new ResWeaponChangeMessage();
            _loc_4.personId = param3 ? (param3) : (UserObj.getInstance().playerInfo.personId);
            _loc_4.weaponId = 0;
            _loc_4.pos = param1;
            _loc_4.weaponStreng = 0;
            MapControl.getInstance().weaponChangeHandler(_loc_4);
            return;
        }// end function

        public function addArmor(param1:int, param2:int = 3, param3:int = 13, param4:long = null) : void
        {
            var _loc_5:* = new ResArmorChangeMessage();
            _loc_5.armorId = param1;
            _loc_5.personId = param4 ? (param4) : (UserObj.getInstance().playerInfo.personId);
            _loc_5.armorStrength = param3;
            MapControl.getInstance().armorChangeHandler(_loc_5);
            return;
        }// end function

        public function removeUserAllBuff() : void
        {
            var _loc_1:* = RoleList.getInstance().player as Player;
            var _loc_2:* = UserObj.getInstance().playerInfo.buffs;
            while (this._fakeBuffList && this._fakeBuffList.length > 0)
            {
                
                _loc_1.info.removeBuff(this._fakeBuffList.shift());
            }
            return;
        }// end function

        public function createBuff(param1:int, param2:IRole) : void
        {
            if (!this._fakeBuffList)
            {
                this._fakeBuffList = [];
            }
            param2.info.removeBuffByModelId(param1);
            var _loc_3:* = new CSBuffInfo();
            _loc_3.modelId = param1;
            _loc_3.buffId = this.getClientId();
            this._fakeBuffList.push(_loc_3.buffId);
            _loc_3.buffparas = new Vector.<BuffPara>;
            var _loc_4:* = param2.info.addBuff(_loc_3);
            param2.addBuffView(_loc_4);
            return;
        }// end function

        public function createBuffByArr(param1:Array, param2:IRole) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            for each (_loc_3 in param1)
            {
                
                this.createBuff(_loc_3, param2);
            }
            return;
        }// end function

        public function getClientId() : long
        {
            var _loc_1:* = this;
            var _loc_2:* = this.lowId + 1;
            _loc_1.lowId = _loc_2;
            return new long(0, this.lowId);
        }// end function

        public function get monNum() : int
        {
            return this._monNum;
        }// end function

        public function set monNum(param1:int) : void
        {
            this._monNum = param1;
            if (this._monNum == 0 && this._curClientZoneControl.curRound > 0)
            {
                this._curClientZoneControl.nextRound();
            }
            if (this._monNum == 3 && this._curClientZoneControl.curRound == 1 && this._curClientZoneControl is ClientZonesSkeletonKingControl)
            {
                ClientZonesSkeletonKingControl(this._curClientZoneControl).roundOneSpeak();
            }
            return;
        }// end function

        public function isInSkeKingZone() : Boolean
        {
            if (MapObj.getInstance().mapID == Params.CLIENT_ZONES_SKE_KING_ID)
            {
                return true;
            }
            if (MapObj.getInstance().mapID == Params.CLIENT_ZONES_DRAGON_KING)
            {
                return true;
            }
            return false;
        }// end function

        public function createFakePassRes() : void
        {
            var _loc_1:* = new ResZonePassShowMessage();
            _loc_1.itemlist = new Vector.<ItemInfo>;
            var _loc_2:* = new ItemInfo();
            _loc_2.itemModelId = -4;
            _loc_2.num = long.fromNumber(21000);
            _loc_1.itemlist.push(_loc_2);
            _loc_2 = new ItemInfo();
            _loc_2.itemModelId = -1;
            _loc_2.num = long.fromNumber(680);
            _loc_1.itemlist.push(_loc_2);
            _loc_1.deathnum = 0;
            _loc_1.isfirst = 1;
            _loc_1.isPass = 1;
            _loc_1.killmonstrnum = 10;
            _loc_1.star = 5;
            _loc_1.time = 59;
            _loc_1.zoneid = -1;
            ZonesControl.getInstance().zoneVirtualPassShow(_loc_1);
            return;
        }// end function

        public function addExp(param1:Number) : void
        {
            var _loc_9:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo;
            var _loc_3:* = _loc_2.exp;
            var _loc_4:* = _loc_3.toNumber() + param1;
            var _loc_5:* = LevelExpCfgObj.getInstance().getExpByLevel(_loc_2.job, _loc_2.level);
            var _loc_6:* = 0;
            while (_loc_4 > _loc_5 && _loc_5 != 0)
            {
                
                _loc_6++;
                _loc_4 = _loc_4 - _loc_5;
                _loc_5 = LevelExpCfgObj.getInstance().getExpByLevel(_loc_2.job, _loc_2.level + _loc_6);
            }
            if (_loc_6 > 0)
            {
                _loc_9 = new ResPlayerLevelUpMessage();
                _loc_9.personId = _loc_2.personId;
                _loc_9.currentLevel = _loc_2.level + _loc_6;
                PlayerControl.getInstance().playerLevelUpHandler(_loc_9);
                _loc_2.fightPower = _loc_2.fightPower + 42 * _loc_6;
            }
            var _loc_7:* = new ResPlayerExpChangeMessage();
            _loc_7.currentExp = long.fromNumber(_loc_4);
            PlayerControl.getInstance().playerExpChangeHandler(_loc_7);
            var _loc_8:* = new PersonalNoticeMessage();
            _loc_8.content = LanguageCfgObj.getInstance().getByIndex("10924");
            _loc_8.goodsinfos = new Vector.<GoodsInfoRes>;
            _loc_8.subtype = 0;
            _loc_8.type = "6";
            _loc_8.values = new Vector.<String>;
            _loc_8.values.push(param1.toString());
            PromptControl.getInstance().personNotice(_loc_8);
            return;
        }// end function

        public function addMoney(param1:Number) : void
        {
            UserObj.getInstance().playerInfo.money = UserObj.getInstance().playerInfo.money + param1;
            var _loc_2:* = new PersonalNoticeMessage();
            _loc_2.content = LanguageCfgObj.getInstance().getByIndex("10925");
            _loc_2.goodsinfos = new Vector.<GoodsInfoRes>;
            _loc_2.subtype = 0;
            _loc_2.type = "6";
            _loc_2.values = new Vector.<String>;
            _loc_2.values.push(param1.toString());
            PromptControl.getInstance().personNotice(_loc_2);
            return;
        }// end function

        public static function getInstance() : MapClientControl
        {
            if (instance == null)
            {
                instance = new MapClientControl;
            }
            return instance;
        }// end function

    }
}
