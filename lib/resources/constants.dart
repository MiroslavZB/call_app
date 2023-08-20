import 'package:flutter/material.dart';
import 'package:worldtime/worldtime.dart';

// Colors
const darkAccentColor = Color.fromRGBO(77, 92, 142, 1);
const lightAccentColor = Color.fromRGBO(222, 226, 247, 1);

// Border Radius
const double smallBorderRadius = 8;
const double mediumBorderRadius = 20;
const double bigBorderRadius = 25;

// Icon size
const double regularIconSize = 25;
const double bigIconSize = 30;
const double extraBigIconSize = 40;
const double contactImageSize = 50;

// Font size
const double sizeH1 = 26.0;
const double sizeH2 = 24.0;
const double sizeH3 = 22.0;
const double sizeH4 = 18.0;
const double sizeH5 = 16.0;
const double sizeH6 = 14.0;

// Font style
const TextStyle styleH1 = TextStyle(fontSize: sizeH1);
const TextStyle styleH2 = TextStyle(fontSize: sizeH2);
const TextStyle styleH3 = TextStyle(fontSize: sizeH3);
const TextStyle styleH4 = TextStyle(fontSize: sizeH4);
const TextStyle styleH5 = TextStyle(fontSize: sizeH5);
const TextStyle styleH6 = TextStyle(fontSize: sizeH6);

// Time
final Worldtime worldTime = Worldtime();
const String formatter = '\\h:\\m \\D.\\M.\\Y';

Map<String, String> countriesFromPhoneCountryCode = {
  '+1': 'USA',
  '+20': 'EGY',
  '+27': 'ZAF',
  '+30': 'GRC',
  '+31': 'NLD',
  '+32': 'BEL',
  '+33': 'FRA',
  '+34': 'ESP',
  '+36': 'HUN',
  '+39': 'ITA',
  '+40': 'ROU',
  '+41': 'CHE',
  '+43': 'AUT',
  '+44': 'UK',
  '+45': 'DNK',
  '+46': 'SWE',
  '+47': 'NOR',
  '+48': 'POL',
  '+49': 'DEU',
  '+51': 'PER',
  '+52': 'MEX',
  '+53': 'CUB',
  '+54': 'ARG',
  '+55': 'BRA',
  '+56': 'CHL',
  '+57': 'COL',
  '+58': 'VEN',
  '+60': 'MYS',
  '+61': 'AUS',
  '+62': 'IDN',
  '+63': 'PHL',
  '+64': 'NZL',
  '+65': 'SGP',
  '+66': 'THA',
  '+81': 'JPN',
  '+82': 'KOR',
  '+84': 'VNM',
  '+86': 'CHN',
  '+90': 'TUR',
  '+91': 'IND',
  '+92': 'PAK',
  '+93': 'AFG',
  '+94': 'LKA',
  '+95': 'MMR',
  '+98': 'IRN',
  '+212': 'MAR',
  '+213': 'DZA',
  '+216': 'TUN',
  '+218': 'LBY',
  '+220': 'GMB',
  '+221': 'SEN',
  '+222': 'MRT',
  '+223': 'MLI',
  '+224': 'GIN',
  '+225': 'CIV',
  '+226': 'BFA',
  '+227': 'NER',
  '+228': 'TGO',
  '+229': 'BEN',
  '+230': 'MUS',
  '+231': 'LBR',
  '+232': 'SLE',
  '+233': 'GHA',
  '+234': 'NGA',
  '+235': 'TCD',
  '+236': 'CAF',
  '+237': 'CMR',
  '+238': 'CPV',
  '+239': 'STP',
  '+240': 'GNQ',
  '+241': 'GAB',
  '+242': 'COG',
  '+243': 'COD',
  '+244': 'AGO',
  '+245': 'GNB',
  '+246': 'IOT',
  '+248': 'SYC',
  '+249': 'SDN',
  '+250': 'RWA',
  '+251': 'ETH',
  '+252': 'SOM',
  '+253': 'DJI',
  '+254': 'KEN',
  '+255': 'TZA',
  '+256': 'UGA',
  '+257': 'BDI',
  '+258': 'MOZ',
  '+260': 'ZMB',
  '+261': 'MDG',
  '+262': 'REU',
  '+263': 'ZWE',
  '+264': 'NAM',
  '+265': 'MWI',
  '+266': 'LSO',
  '+267': 'BWA',
  '+268': 'SWZ',
  '+269': 'COM',
  '+290': 'SHN',
  '+291': 'ERI',
  '+297': 'ABW',
  '+298': 'FRO',
  '+299': 'GRL',
  '+350': 'GIB',
  '+351': 'PRT',
  '+352': 'LUX',
  '+353': 'IRL',
  '+354': 'ISL',
  '+355': 'ALB',
  '+356': 'MLT',
  '+357': 'CYP',
  '+358': 'FIN',
  '+359': 'BGR',
  '+370': 'LTU',
  '+371': 'LVA',
  '+372': 'EST',
  '+373': 'MDA',
  '+374': 'ARM',
  '+375': 'BLR',
  '+376': 'AND',
  '+377': 'MCO',
  '+378': 'SMR',
  '+379': 'VA',
  '+380': 'UKR',
  '+381': 'SRB',
  '+382': 'MNE',
  '+383': 'XKX',
  '+385': 'HRV',
  '+386': 'SVN',
  '+387': 'BIH',
  '+389': 'MKD',
  '+420': 'CZE',
  '+421': 'SVK',
  '+423': 'LIE',
  '+500': 'FLK',
  '+501': 'BLZ',
  '+502': 'GTM',
  '+503': 'SLV',
  '+504': 'HND',
  '+505': 'NIC',
  '+506': 'CRI',
  '+507': 'PAN',
  '+508': 'SPM',
  '+509': 'HTI',
  '+590': 'BLM',
  '+591': 'BOL',
  '+592': 'GUY',
  '+593': 'ECU',
  '+594': 'GUF',
  '+595': 'PRY',
  '+596': 'MTQ',
  '+599': 'CUW',
};
