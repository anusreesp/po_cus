
import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:htp_customer/features/clubs/presentation/pages/club_details_old.dart';
import 'package:htp_customer/features/clubs/presentation/pages/new/club_details_page.dart';
import 'package:htp_customer/features/dashboard/data/models/search_result.dart';
import 'package:htp_customer/features/dashboard/data/services/dashboard_service.dart';
import 'package:htp_customer/features/event/presentation/pages/events_details.dart';
import 'package:htp_customer/htp_theme.dart';

import '../../controllers/dashboard_controllers.dart';
import '../../controllers/location_controller.dart';

class SearchBox extends ConsumerWidget {
  final TextEditingController? controller;
  final Function(bool)? onSuggestionBoxToggle;
  const SearchBox({Key? key, this.controller, this.onSuggestionBoxToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const UnderlineInputBorder inputStyle =  UnderlineInputBorder(borderSide: BorderSide(color: HtpTheme.goldenColor));
    return TypeAheadField<SearchResult>(
      noItemsFoundBuilder:(context){
        return const Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text("No result found!",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        );
      },
      // controller: controller,
      hideKeyboardOnDrag: false,
      hideSuggestionsOnKeyboardHide: true,
      onSuggestionsBoxToggle: (boxVisible) {
        // print("SUGGEST: $box");
        if (onSuggestionBoxToggle != null) {
          onSuggestionBoxToggle!(boxVisible);
        }

        if (boxVisible == false) {
          controller?.clear();
        }
      },
      itemBuilder: (BuildContext context, SearchResult suggestion) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                '${suggestion.name}${suggestion.cityName != null ? ' - ${suggestion.cityName!.toCapitalCase()}' : ''}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                softWrap: true,
              )),
              const SizedBox(
                width: 8,
              ),
              Text(
                suggestion.type.name.toTitleCase(),
                style: const TextStyle(fontWeight: FontWeight.w200),
              )
            ],
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        if (suggestion.type == SearchType.event) {
          ref.read(dashboardProvider.notifier).gotoPage(
              TabItem.events, EventDetails.route,
              arguments: suggestion.id);
          // controller?.clear();
          return;
        }

        if (suggestion.type == SearchType.club) {
          ref.read(dashboardProvider.notifier).gotoPage(
              TabItem.clubs, ClubDetailsPage.route,
              arguments: suggestion.id);
          return;
        }

        if (suggestion.type == SearchType.location) {
          ref
              .read(userLocationProvider.notifier)
              .selectManualLocation(suggestion.name, suggestion.id, null);
          ref.read(dashboardProvider.notifier).selectTabHome(TabItem.clubs);
        }
      },
      suggestionsCallback: (pattern) async {
        return await ref
            .read(dashboardServiceProvider)
            .getSearchResult(pattern);
      },
      textFieldConfiguration: TextFieldConfiguration(
          // style: DefaultTextStyle.of(context).style.copyWith()
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: inputStyle,
            enabledBorder: inputStyle,
            // fillColor: Colors.white24,
            // filled: true,
            hintText: "Search for Clubs, Events, Locations",
            hintStyle: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.white.withOpacity(0.6)),
          )),
    );

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(26),
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16,),
    //     child: TypeAheadField<SearchResult>(
    //       // controller: controller,
    //       hideKeyboardOnDrag: false,
    //       hideSuggestionsOnKeyboardHide: true,
    //       onSuggestionsBoxToggle: (boxVisible){
    //         // print("SUGGEST: $box");
    //         if(boxVisible == false){
    //           controller?.clear();
    //         }
    //       },
    //       itemBuilder: (BuildContext context, SearchResult suggestion){
    //         return Padding(
    //           padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
    //           child: Row(
    //             children: [
    //               Expanded(child: Text(suggestion.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold), softWrap: true,)),
    //               const SizedBox(width: 8,),
    //               Text(suggestion.type.name.toTitleCase(), style: const TextStyle(fontWeight: FontWeight.w200),)
    //             ],
    //           ),
    //         );
    //       },
    //       onSuggestionSelected: (suggestion){
    //         if(suggestion.type == SearchType.event){
    //           ref.read(dashboardProvider.notifier).gotoPage(TabItem.events, EventDetails.route, arguments: suggestion.id);
    //           // controller?.clear();
    //           return;
    //         }
    //
    //         if(suggestion.type == SearchType.club){
    //           ref.read(dashboardProvider.notifier).gotoPage(TabItem.clubs, ClubDetails.route, arguments: suggestion.id);
    //           return;
    //         }
    //
    //         if(suggestion.type == SearchType.location){
    //           ref.read(userLocationProvider.notifier).selectManualLocation(suggestion.name, suggestion.id, null);
    //           ref.read(dashboardProvider.notifier).selectTabHome(TabItem.clubs);
    //         }
    //       },
    //       suggestionsCallback: (pattern) async{
    //         return await ref.read(dashboardServiceProvider).getSearchResult(pattern);
    //       },
    //       textFieldConfiguration: TextFieldConfiguration(
    //         // style: DefaultTextStyle.of(context).style.copyWith()
    //         controller: controller,
    //           decoration: InputDecoration(
    //             suffixIcon:
    //             // SvgPicture.asset(
    //             //   'assets/svg/icons/search.svg',
    //             //   fit: BoxFit.fill,
    //             // ),
    //
    //             const Icon(
    //               Icons.search,
    //               color: Color(0xffe8d48a),
    //             ),
    //             fillColor: Colors.white24,
    //             filled: true,
    //             hintText: "      Search for Clubs, Events, Locations",
    //             hintStyle: TextStyle(
    //                 fontSize: 12,
    //                 fontStyle: FontStyle.italic,
    //                 color: Colors.white.withOpacity(0.6)),
    //             contentPadding:
    //             const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    //             disabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(50),
    //                 borderSide: BorderSide(
    //                   color: Colors.white.withOpacity(0.4),
    //                 )),
    //             border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(50),
    //                 borderSide: BorderSide(
    //                   color: Colors.white.withOpacity(0.4),
    //                 )),
    //             enabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(50),
    //                 borderSide: BorderSide(
    //                   color: Colors.white.withOpacity(0.2),
    //                 )),
    //             focusedBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(50),
    //                 borderSide: BorderSide(
    //                   color: Colors.white.withOpacity(0.2),
    //                 )),
    //           )
    //       ),
    //
    //
    //     ),
    //   ),
    // );
  }
}
