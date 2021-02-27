import com.sweak.abstractsqlmodel 1.0

AbstractDayListView {
    model: AbstractSqlModel
    {
        query: "SELECT * FROM Monday ORDER BY ActivityTime ASC"
    }
}
