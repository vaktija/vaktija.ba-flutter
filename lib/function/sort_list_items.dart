List sortListItemsAlphabetically(List listData) {
  listData.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });
  return listData;
}

List sortListItemsByNumber(List listData) {
  listData.sort((a, b) {
    return a.compareTo(b);
  });
  return listData;
}

List sortDrzaveAlphabetically(List listData) {
  listData.sort((a, b) {
    return a['DrzavaIme'].toLowerCase().compareTo(b['DrzavaIme'].toLowerCase());
  });
  return listData;
}

List sortGradoviAlphabetically(List listData) {
  listData.sort((a, b) {
    return a['IlceAdiEn']
        .toString()
        .toLowerCase()
        .compareTo(b['IlceAdiEn'].toString().toLowerCase());
  });
  return listData;
}
