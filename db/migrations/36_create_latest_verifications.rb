Sequel.migration do
  up do
    create_or_replace_view(:latest_verifications,
      "SELECT v.id, v.number, v.success, v.provider_version, v.build_url, v.pact_version_id
        FROM verifications v
        INNER JOIN (
        SELECT pact_version_id, MAX(number) latest_number
          FROM verifications
          GROUP BY pact_version_id
        ) lv ON v.pact_version_id = lv.pact_version_id AND v.number = lv.latest_number"
    )
  end
end
