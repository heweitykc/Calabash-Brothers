package com.game.stalls.handler
{
    import __AS3__.vec.*;
    import com.game.stalls.control.*;
    import com.game.stalls.message.*;
    import com.game.stalls.model.*;
    import com.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResStallsSearchHandler extends Handler
    {

        public function ResStallsSearchHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = ResStallsSearchMessage(this.message);
            var _loc_2:* = _loc_1.stallsbrieflist.stallsbrieflist.length;
            var _loc_3:* = new Vector.<StallsBriefInfo>;
            StallsObj.getInstance().self = false;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = new StallsBriefInfo();
                _loc_5.playerid = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].playerid;
                _loc_5.playerlv = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].playerlv;
                _loc_5.playername = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].playername;
                _loc_5.sellgold = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].sellgold;
                _loc_5.sellyuanbao = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].sellyuanbao;
                _loc_5.stallsid = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].stallsid;
                _loc_5.stallslv = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].stallslv;
                _loc_5.stallsname = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].stallsname;
                _loc_5.sellgoodsnum = _loc_1.stallsbrieflist.stallsbrieflist[_loc_4].sellgoodsnum;
                if (_loc_5.playerid.equal(UserObj.getInstance().playerInfo.personId))
                {
                    StallsObj.getInstance().self = true;
                }
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            StallsObj.getInstance().breflist = _loc_3;
            StallsObj.getInstance().indexLarge = _loc_1.stallsbrieflist.indexLarge;
            StallsObj.getInstance().indexlittle = _loc_1.stallsbrieflist.indexlittle;
            StallsControl.getInstance().updateList();
            return;
        }// end function

    }
}
