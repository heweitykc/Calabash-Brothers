package com.model.vo
{
    import com.cfg.info.*;
    import com.f1.utils.path.*;
    import com.game.team.bean.*;
    import com.game.utils.*;
    import com.staticdata.*;

    public class BigMapItemInfo extends Object
    {
        public var itemId:Number;
        public var itemType:String;
        public var resourceURL:String;
        public var posX:int;
        public var posY:int;
        public var serverId:long;
        public var des:String;

        public function BigMapItemInfo()
        {
            return;
        }// end function

        public function conByNpcObj(param1:NpcCfg) : void
        {
            this.itemId = param1._npcModelId;
            this.itemType = Params.BIG_MAP_NPC;
            this.resourceURL = Params.OTHER_PATH + this.itemType + ".png";
            var _loc_2:* = MapUtils.tile2Coo([param1._x, param1._y]);
            this.posX = _loc_2[0];
            this.posY = _loc_2[1];
            return;
        }// end function

        public function conByTransferInfo(param1:TransferInfo) : void
        {
            this.itemId = param1.q_tran_id;
            this.itemType = Params.BIG_MAP_TRANSFOR;
            this.resourceURL = Params.OTHER_PATH + this.itemType + ".png";
            this.posX = param1.x;
            this.posY = param1.y;
            return;
        }// end function

        public function conByMonInfo(param1:WorldMapMonInfo) : void
        {
            this.itemId = 0;
            this.itemType = Params.BIG_MAP_RECT_MONSTER;
            this.resourceURL = Params.OTHER_PATH + this.itemType + ".png";
            var _loc_2:* = MapUtils.tile2Coo([param1.monX, param1.monY]);
            this.posX = _loc_2[0];
            this.posY = _loc_2[1];
            this.des = param1.monName;
            return;
        }// end function

        public function conByBossInfo(param1:WorldMapMonInfo) : void
        {
            this.itemId = 0;
            this.itemType = Params.BIG_MAP_BOSS;
            this.resourceURL = Params.OTHER_PATH + this.itemType + ".png";
            var _loc_2:* = MapUtils.tile2Coo([param1.monX, param1.monY]);
            this.posX = _loc_2[0];
            this.posY = _loc_2[1];
            this.des = param1.monName;
            return;
        }// end function

        public function conByCreamInfo(param1:WorldMapMonInfo) : void
        {
            this.itemId = 0;
            this.itemType = Params.BIG_MAP_CREAM;
            this.resourceURL = Params.OTHER_PATH + this.itemType + ".png";
            var _loc_2:* = MapUtils.tile2Coo([param1.monX, param1.monY]);
            this.posX = _loc_2[0];
            this.posY = _loc_2[1];
            this.des = param1.monName;
            return;
        }// end function

        public function conByTeamInfo(param1:TeamMemberInfo) : void
        {
            this.serverId = param1.memberid;
            this.itemType = Params.BIG_MAP_TEAMMATE;
            this.resourceURL = Params.OTHER_PATH + this.itemType + ".png";
            this.posX = param1.mx;
            this.posY = param1.my;
            this.des = param1.membername;
            return;
        }// end function

    }
}
