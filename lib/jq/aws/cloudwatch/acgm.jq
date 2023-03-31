def acgm: .MetricDataResults[0]
          | [(.Timestamps | length)
          , (.Values | add)]
          | "\(.[0]),\(.[1]/1000000 | floor)MB"
          ;
# def acgm: .;
